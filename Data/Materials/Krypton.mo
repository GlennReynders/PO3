within PO3_basics.Data.Materials;
record Krypton = PO3_basics.Data.Interfaces.Material (
    k=0.0086,
    c=245,
    rho=3.56,
    epsSw=0,
    epsLw=0,
    gas=true,
    mhu=23.0*10e-6) "Krypton gass";
