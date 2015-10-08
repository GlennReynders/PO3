within PO3.Data.Materials;
record Concrete = PO3.Data.Interfaces.Material (
    k=1.4,
    c=840,
    rho=2100,
    epsLw=0.88,
    epsSw=0.55) "Dense cast concrete, also for finishing";
