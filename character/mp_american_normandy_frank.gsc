// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\mp_body_american_normandy::main());
	self setViewmodel("xmodel/viewmodel_hands_cloth");
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\mp_body_american_normandy::main());
	precacheModel("xmodel/viewmodel_hands_cloth");
}
