extends Node2D

@onready var wave:WaveFunctionCollapse = $WaveFunctionCollapse

@export var Tile:Dictionary = {
	LINE_H = Vector2i(0,0),
	LINE_V = Vector2i(0,1),
	X = Vector2i(0,2),
	EMPTY = Vector2i(0,3),
	TR = Vector2i(1,0),
	TL = Vector2i(1,1),
	BR = Vector2i(1,2),
	BL = Vector2i(1,3),
}



# Called when the node enters the scene tree for the first time.
func _ready():
	test()
	wave.generate()

func all_rules():
	for key in Tile.keys():
		for ohter_key in Tile.keys():
			for dir in wave.directions:
				wave.add_rules(Tile[key], [dir], [Tile[ohter_key]])

func remove_rules():
	wave.add_rules(Tile.LINE_H, [Vector3i.DOWN],  [Tile.LINE_V, Tile.T_L, Tile.T_R, Tile.T, Tile.X, Tile.CORNER_BL, Tile.CORNER_BR])
	wave.add_rules(Tile.LINE_H, [Vector3i.UP],    [Tile.LINE_V, Tile.T_L, Tile.T_R, Tile.T_U, Tile.X, Tile.CORNER_TL, Tile.CORNER_TR])
	wave.add_rules(Tile.LINE_H, [Vector3i.RIGHT], [Tile.LINE_V, Tile.T_L, Tile.CORNER_TR, Tile.CORNER_BR])
	wave.add_rules(Tile.LINE_H, [Vector3i.LEFT],  [Tile.LINE_V, Tile.T_R, Tile.CORNER_TL, Tile.CORNER_BL])
	
	wave.add_rules(Tile.LINE_V, [Vector3i.RIGHT], [Tile.LINE_H, Tile.T, Tile.T_L, Tile.T_U, Tile.X, Tile.CORNER_BL, Tile.CORNER_TL])
	wave.add_rules(Tile.LINE_V, [Vector3i.LEFT],  [Tile.LINE_H, Tile.T, Tile.T_R, Tile.T_U, Tile.X, Tile.CORNER_BR, Tile.CORNER_TR])
	wave.add_rules(Tile.LINE_V, [Vector3i.DOWN],  [Tile.LINE_H, Tile.T_U, Tile.CORNER_TL, Tile.CORNER_TR])
	wave.add_rules(Tile.LINE_V, [Vector3i.UP],    [Tile.LINE_H, Tile.T, Tile.CORNER_BL, Tile.CORNER_BR])

func test():
	wave.add_rules(Tile.EMPTY, [Vector3i.LEFT], [Tile.EMPTY, Tile.LINE_V, Tile.TL, Tile.BL])
	wave.add_rules(Tile.EMPTY, [Vector3i.RIGHT], [Tile.EMPTY, Tile.LINE_V, Tile.TR, Tile.BR])
	wave.add_rules(Tile.EMPTY, [Vector3i.UP], [Tile.EMPTY, Tile.LINE_H, Tile.BR, Tile.BL])
	wave.add_rules(Tile.EMPTY, [Vector3i.DOWN], [Tile.EMPTY, Tile.LINE_H, Tile.TR, Tile.TL])
	
	wave.add_rules(Tile.X, [Vector3i.LEFT], [Tile.X, Tile.LINE_H, Tile.TR, Tile.BR])
	wave.add_rules(Tile.X, [Vector3i.RIGHT], [Tile.X, Tile.LINE_H, Tile.TL, Tile.BL])
	wave.add_rules(Tile.X, [Vector3i.DOWN], [Tile.X, Tile.LINE_V, Tile.BR, Tile.BL])
	wave.add_rules(Tile.X, [Vector3i.UP], [Tile.X, Tile.LINE_V, Tile.TR, Tile.TL])
	
	wave.add_rules(Tile.LINE_H, [Vector3i.DOWN], [Tile.LINE_H, Tile.TR, Tile.TL])
	wave.add_rules(Tile.LINE_H, [Vector3i.UP], [Tile.LINE_H, Tile.BR, Tile.BL])
	wave.add_rules(Tile.LINE_H, [Vector3i.LEFT], [Tile.LINE_H, Tile.TR, Tile.BR])
	wave.add_rules(Tile.LINE_H, [Vector3i.RIGHT], [Tile.LINE_H, Tile.TL, Tile.BL])
	
	wave.add_rules(Tile.LINE_V, [Vector3i.DOWN], [Tile.LINE_V, Tile.BR, Tile.BL])
	wave.add_rules(Tile.LINE_V, [Vector3i.UP], [Tile.LINE_V, Tile.TR, Tile.TL])
	wave.add_rules(Tile.LINE_V, [Vector3i.LEFT], [Tile.LINE_V, Tile.TL, Tile.BL])
	wave.add_rules(Tile.LINE_V, [Vector3i.RIGHT], [Tile.LINE_V, Tile.TR, Tile.BR])
	
	wave.add_rules(Tile.TR, [Vector3i.DOWN], [Tile.BR, Tile.BL])
	wave.add_rules(Tile.TR, [Vector3i.UP], [Tile.BR, Tile.BL])
	wave.add_rules(Tile.TR, [Vector3i.LEFT], [Tile.TL, Tile.BL])
	wave.add_rules(Tile.TR, [Vector3i.RIGHT], [Tile.TL, Tile.BL])
	
	wave.add_rules(Tile.TL, [Vector3i.DOWN], [Tile.BR, Tile.BL])
	wave.add_rules(Tile.TL, [Vector3i.UP], [Tile.BR, Tile.BL])
	wave.add_rules(Tile.TL, [Vector3i.LEFT], [Tile.TR, Tile.BR])
	wave.add_rules(Tile.TL, [Vector3i.RIGHT], [Tile.TR, Tile.BR])
	
	wave.add_rules(Tile.BR, [Vector3i.LEFT], [Tile.BL])
	wave.add_rules(Tile.BR, [Vector3i.RIGHT], [Tile.BL ])
	
	
