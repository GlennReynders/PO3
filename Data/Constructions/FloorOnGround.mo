within PO3_basics.Data.Constructions;
record FloorOnGround "Example - Floor on ground for floor heating system"

  extends PO3_basics.Data.Interfaces.Construction(
    nLay=4,
    locGain=2,
    mats={Materials.Concrete(d=0.20),insulationType,Materials.Screed(d=0.08),
        Materials.Concrete(d=0.015)});

end FloorOnGround;