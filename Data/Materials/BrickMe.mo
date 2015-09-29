within PO3_basics.Data.Materials;
record BrickMe = PO3_basics.Data.Interfaces.Material (
    k=0.75,
    c=840,
    rho=1400,
    epsLw=0.88,
    epsSw=0.55) "Medium masonry for exterior applications ";
