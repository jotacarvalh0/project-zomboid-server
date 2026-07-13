# Gameplay Core v0.1 — Auditoria inicial

## StagingB42.ini

2:PVP=true
11:PauseEmpty=true
19:Open=true
40:SafetySystem=true
43:ShowSafety=true
67:Mods=NF_UI
81:PublicName=Nova Fronteira Beta
84:PublicDescription=Servidor fechado de testes do projeto Project Zomboid B-42.
88:MaxPlayers=32
100:NoFire=false
112:PlayerSafehouse=false
115:AdminSafehouse=false
144:AllowDestructionBySledgehammer=true
197:SleepAllowed=false
200:SleepNeeded=false
210:WorkshopItems=

## StagingB42_SandboxVars.lua

10:    Zombies = 4,
14:    Distribution = 1,
22:    ZombieRespawn = 4,
110:    WaterShut = 2,
121:    ElecShut = 2,
131:    WaterShutModifier = 14,
133:    ElecShutModifier = 14,
137:    FoodLootNew = 0.8,
139:    LiteratureLootNew = 0.6,
145:    MedicalLootNew = 0.6,
147:    SurvivalGearsLootNew = 0.6,
149:    CannedFoodLootNew = 0.6,
151:    WeaponLootNew = 0.6,
153:    RangedWeaponLootNew = 1.2,
155:    AmmoLootNew = 0.6,
157:    MechanicsLootNew = 0.6,
159:    OtherLootNew = 0.8,
220:    ErosionSpeed = 4,
253:    NatureAbundance = 3,
290:    SeenHoursPreventLootRespawn = 0,
292:    HoursForLootRespawn = 0,
294:    MaxItemsForLootRespawn = 5,
296:    ConstructionPreventsLootRespawn = true,
317:    TimeSinceApo = 1,
428:    FireSpread = true,
487:    CarSpawnRate = 3,
499:    InitialGas = 2,
515:    LockedCar = 4,
524:    CarGeneralCondition = 3,
557:    ChanceHasGas = 2,
565:    MultiHitZombies = false,
572:    SirenEffectsZombies = true,
645:    AnimalSoundAttractZombies = true,
742:    -- Replaces Chance-To-Hit mechanics with Chance-To-Damage calculations.  This mode prioritizes player aiming. Default = Zombies only
744:    -- 2 = Zombies only
883:        ZombiesDragDown = true,
885:        ZombiesCrawlersDragDown = false,
887:        ZombiesFenceLunge = true,
889:        ZombiesArmorFactor = 2.0,
891:        ZombiesMaxDefense = 85,
895:        ZombiesFallDamage = 1.0,
896:        -- Whether some dead-looking zombies will reanimate and attack the player. Default = World Zombies
897:        -- 1 = World Zombies
898:        -- 2 = World and Combat Zombies
901:        -- Zombies will not spawn where players spawn. Default = Inside the building and around it
905:        -- 4 = Zombies can spawn anywhere
922:        RespawnHours = 0.0,
924:        RespawnUnseenHours = 0.0,
925:        -- The fraction of a cell's desired population that may respawn every RespawnHours. Min: 0.00 Max: 1.00 Default: 0.00
926:        RespawnMultiplier = 0.0,
928:        RedistributeHours = 12.0,
942:        ZombiesCountBeforeDelete = 300,
