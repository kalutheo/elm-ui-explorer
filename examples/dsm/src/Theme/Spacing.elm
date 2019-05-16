module Theme.Spacing exposing (Spacing, SpacingStyle, extraLarge, getSpacing, large, largest, medium, small, smallest, spacing)


type alias SpacingStyle =
    { value : Int, name : String }


type alias SpacingTheme =
    { xs : Spacing
    , s : Spacing
    , m : Spacing
    , l : Spacing
    , xl : Spacing
    , xxl : Spacing
    }


type Spacing
    = XS SpacingStyle
    | S SpacingStyle
    | M SpacingStyle
    | L SpacingStyle
    | XL SpacingStyle
    | XXL SpacingStyle


getSpacing : Spacing -> SpacingStyle
getSpacing sp =
    case sp of
        XS s ->
            s

        S s ->
            s

        M s ->
            s

        L s ->
            s

        XL s ->
            s

        XXL s ->
            s


smallest : SpacingStyle
smallest =
    getSpacing spacing.xs


small : SpacingStyle
small =
    getSpacing spacing.s


medium : SpacingStyle
medium =
    getSpacing spacing.m


large : SpacingStyle
large =
    getSpacing spacing.l


extraLarge : SpacingStyle
extraLarge =
    getSpacing spacing.xl


largest : SpacingStyle
largest =
    getSpacing spacing.xxl


spacing : SpacingTheme
spacing =
    { xs = XS { value = 4, name = "Smallest" }
    , s = S { value = 8, name = "Small" }
    , m = M { value = 12, name = "Medium" }
    , l = L { value = 22, name = "Large" }
    , xl = XL { value = 26, name = "ExtraLarge" }
    , xxl = XXL { value = 36, name = "Largest" }
    }
