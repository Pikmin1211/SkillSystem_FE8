#include "gbafe.h"

void ComputeBattleUnitHitRate(struct BattleUnit* bu) {
    bu->battleHitRate = (bu->unit.skl * 2) + GetItemHit(bu->weapon) + (bu->unit.lck / 2) + bu->wTriangleHitBonus;
}