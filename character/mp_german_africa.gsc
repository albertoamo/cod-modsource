// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\mp_body_german_normandy::main());
	self setViewmodel("xmodel/viewmodel_hands_german");
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\mp_body_german_normandy::main());
	precacheModel("xmodel/viewmodel_hands_german");
}