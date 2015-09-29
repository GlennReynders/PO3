within PO3_basics.Data.Insulation;
record Rockwool = PO3_basics.Data.Interfaces.Insulation (
    final k=0.036,
    final c=840,
    final rho=110,
    final epsLw=0.8,
    final epsSw=0.8) "Rockwool";
