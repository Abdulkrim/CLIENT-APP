double getLeftSpaceTopTabBar(
        {required double tabWidth, required int currentPos, required int tabItemsCount}) =>
    currentPos == 0 ? 0 : (tabWidth / tabItemsCount) * currentPos;

double getTopTabBarSelectedBoxWidth({required double tabWidth, required int tabItemsCount}) => tabWidth / tabItemsCount;

