/obj/item/weapon/book/manual/security_space_law
	name = "Corporate Regulations"
	desc = "A set of NanoTrasen guidelines for keeping law and order on their space stations."
	icon_state = "bookSpaceLaw"
	author = "NanoTrasen"
	title = "Corporate Regulations"

/obj/item/weapon/book/manual/security_space_law/New()
	..()
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="[config.wikiurl]Corporate_Regulations&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>
		</html>
		"}