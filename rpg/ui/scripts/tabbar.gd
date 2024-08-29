extends TabBar

@export var tabs : Array[Control]

func swap_tab(tab : int):
	#disable all tabs
	for _tab in tabs:
		_tab.visible = false
	
	#enable the tab you need
	tabs[tab].visible = true
