package net.mcreator.mysticalcreepytom;

import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.MobType;
import net.minecraft.world.entity.PathfinderMob;
import net.minecraft.world.entity.ai.attributes.AttributeSupplier;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.entity.ai.goal.FloatGoal;
import net.minecraft.world.entity.ai.goal.LookAtPlayerGoal;
import net.minecraft.world.entity.ai.goal.RandomLookAroundGoal;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.level.Level;
import net.minecraft.world.phys.AABB;
import net.minecraft.network.chat.Component;
import net.minecraft.core.particles.ParticleTypes;

import java.util.List;
import java.util.Random;

/**
 * ВСТАВЬ ЭТОТ ФАЙЛ В MCreator КАК "Custom code class".
 * Затем создай Living Entity "Tom" и в его tick/update вызови TomController.tickTom(...).
 */
public class MCreator_Tom_CustomCode {

    public static class TomEntity extends PathfinderMob {
        private long stareStart = -1;
        private long autoDisappearAt = -1;
        private final Random r = new Random();

        protected TomEntity(net.minecraft.world.entity.EntityType<? extends PathfinderMob> type, Level level) {
            super(type, level);
            this.noPhysics = false;
            this.setNoAi(false);
            this.setSilent(true);
        }

        public static AttributeSupplier.Builder createAttributes() {
            return Mob.createMobAttributes()
                    .add(Attributes.MAX_HEALTH, 20.0)
                    .add(Attributes.MOVEMENT_SPEED, 0.1)
                    .add(Attributes.FOLLOW_RANGE, 96.0)
                    .add(Attributes.ATTACK_DAMAGE, 3.0);
        }

        @Override
        protected void registerGoals() {
            this.goalSelector.addGoal(0, new FloatGoal(this));
            this.goalSelector.addGoal(1, new LookAtPlayerGoal(this, Player.class, 128.0f));
            this.goalSelector.addGoal(2, new RandomLookAroundGoal(this));
        }

        @Override
        public MobType getMobType() {
            return MobType.UNDEFINED;
        }

        @Override
        public void tick() {
            super.tick();
            if (!(level() instanceof ServerLevel sl)) return;

            List<ServerPlayer> players = sl.getEntitiesOfClass(ServerPlayer.class, new AABB(blockPosition()).inflate(128));
            if (players.isEmpty()) return;
            ServerPlayer target = players.get(0);

            // Если игрок отвернулся в течение 5 секунд — Tom пропадает.
            boolean looking = TomController.isPlayerLookingAt(target, this, 0.985);
            if (looking && stareStart < 0) {
                stareStart = sl.getGameTime();
            }

            if (!looking && stareStart > 0 && sl.getGameTime() - stareStart <= 100) {
                this.discard();
                return;
            }

            // После 5 секунд — непредсказуемое поведение + таймер исчезновения 10с..2м.
            if (looking && stareStart > 0 && sl.getGameTime() - stareStart >= 100) {
                if (autoDisappearAt < 0) {
                    autoDisappearAt = sl.getGameTime() + (200 + r.nextInt(2201));
                }
                if (r.nextInt(200) == 0) {
                    TomController.randomScaryAction(sl, target, this);
                }
            }

            if (autoDisappearAt > 0 && sl.getGameTime() >= autoDisappearAt) {
                this.discard();
            }
        }

        @Override
        public void playerTouch(Player player) {
            super.playerTouch(player);
            // Если до него дотронуться — пропадает.
            if (!level().isClientSide) {
                this.discard();
            }
        }
    }

    public static class TomController {
        private static final String[] SCARY_LINES = {
                "i see you",
                "don't blink",
                "why are you still here",
                "the fog remembers",
                "turn around",
                "i was never far"
        };

        public static void spawnTomWithFog(ServerLevel level, ServerPlayer player, net.minecraft.world.entity.EntityType<?> tomType) {
            double dx = (level.random.nextDouble() - 0.5) * 80.0;
            double dz = (level.random.nextDouble() - 0.5) * 80.0;
            double x = player.getX() + dx;
            double y = player.getY();
            double z = player.getZ() + dz;

            var e = tomType.create(level);
            if (e == null) return;
            e.teleportTo(x, y, z);
            level.addFreshEntity(e);

            // Резкий туман (визуально через густые частицы вокруг игрока).
            for (int i = 0; i < 400; i++) {
                double px = player.getX() + (level.random.nextDouble() - 0.5) * 18;
                double py = player.getY() + level.random.nextDouble() * 4;
                double pz = player.getZ() + (level.random.nextDouble() - 0.5) * 18;
                level.sendParticles(ParticleTypes.CLOUD, px, py, pz, 1, 0.02, 0.02, 0.02, 0.005);
            }
        }

        public static boolean isPlayerLookingAt(ServerPlayer player, net.minecraft.world.entity.Entity entity, double threshold) {
            var eye = player.getEyePosition();
            var look = player.getViewVector(1.0f).normalize();
            var to = entity.position().add(0, entity.getBbHeight() * 0.7, 0).subtract(eye).normalize();
            return look.dot(to) > threshold;
        }

        public static void randomScaryAction(ServerLevel level, ServerPlayer target, net.minecraft.world.entity.Entity tom) {
            int action = level.random.nextInt(4);
            switch (action) {
                case 0 -> target.sendSystemMessage(Component.literal("<Tom> " + SCARY_LINES[level.random.nextInt(SCARY_LINES.length)]));
                case 1 -> tom.teleportTo(target.getX() + (level.random.nextDouble() - 0.5) * 12, target.getY(), target.getZ() + (level.random.nextDouble() - 0.5) * 12);
                case 2 -> target.setDeltaMovement(target.getDeltaMovement().x, 0.55, target.getDeltaMovement().z);
                case 3 -> {
                    if (level.random.nextBoolean()) tom.discard();
                }
            }
        }
    }
}
