within PO3.Data.Materials;
record Argon = PO3.Data.Interfaces.Material (
    k=0.0162,
    c=519,
    rho=1.70,
    epsSw=0,
    epsLw=0,
    gas=true,
    mhu=22.9*10e-6) "Argon gass";
