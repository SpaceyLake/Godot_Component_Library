extends Node2D

@onready var wave:WaveFunctionCollapse = $WaveFunctionCollapse

@export var Tile:Dictionary = {
	LINE_H = Vector2i(0,0),
	T = Vector2i(1,0),
	T_U = Vector2i(2,0),
	X = Vector2i(3,0),
	LINE_V = Vector2i(0,1),
	T_L = Vector2i(1,1),
	T_R = Vector2i(2,1),
	EMPTY = Vector2i(3,1),
	CORNER_TR = Vector2i(0,2),
	CORNER_TL = Vector2i(1,2),
	CORNER_BR = Vector2i(2,2),
	CORNER_BL = Vector2i(3,2),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	wave.add_rules(Tile.LINE_H, [Vector3i.RIGHT,Vector3i.LEFT], [Tile.LINE_H,Tile.T,Tile.T_U,Tile.X])
	wave.add_rules(Tile.LINE_H, [Vector3i.RIGHT], [Tile.T_L])
	wave.add_rules(Tile.LINE_H, [Vector3i.LEFT], [Tile.T_R])
	wave.add_rules(Tile.LINE_H, [Vector3i.UP,Vector3i.DOWN], [Tile.EMPTY,Tile.LINE_H])
	wave.add_rules(Tile.LINE_H, [Vector3i.UP], [Tile.T])
	wave.add_rules(Tile.LINE_H, [Vector3i.DOWN], [Tile.T_U])

	wave.add_rules(Tile.T, [Vector3i.RIGHT,Vector3i.LEFT], [Tile.T,Tile.LINE_H,Tile.T_U,Tile.X])
	wave.add_rules(Tile.T, [Vector3i.RIGHT], [Tile.T_L])
	wave.add_rules(Tile.T, [Vector3i.LEFT], [Tile.T_R])
	wave.add_rules(Tile.T, [Vector3i.UP], [Tile.T_L,Tile.T_R,Tile.X])
	wave.add_rules(Tile.T, [Vector3i.DOWN], [Tile.EMPTY])

	wave.add_rules(Tile.T_U, [Vector3i.RIGHT,Vector3i.LEFT], [Tile.T_U,Tile.T,Tile.LINE_H,Tile.X])
	wave.add_rules(Tile.T_U, [Vector3i.RIGHT], [Tile.T_L])
	wave.add_rules(Tile.T_U, [Vector3i.LEFT], [Tile.T_R])
	wave.add_rules(Tile.T_U, [Vector3i.DOWN], [Tile.T_L,Tile.T_R,Tile.X])
	wave.add_rules(Tile.T_U, [Vector3i.UP], [Tile.EMPTY])

	wave.add_rules(Tile.X, [Vector3i.RIGHT,Vector3i.LEFT], [Tile.X,Tile.T,Tile.T_U,Tile.LINE_H])
	wave.add_rules(Tile.X, [Vector3i.RIGHT], [Tile.T_L])
	wave.add_rules(Tile.X, [Vector3i.LEFT], [Tile.T_R])
	wave.add_rules(Tile.X, [Vector3i.UP], [Tile.CORNER_TR,Tile.CORNER_TL])
	wave.add_rules(Tile.X, [Vector3i.DOWN], [Tile.CORNER_BR,Tile.CORNER_BL])
	wave.add_rules(Tile.X, [Vector3i.UP, Vector3i.DOWN], [Tile.T_L,Tile.T_R,Tile.LINE_V,Tile.T_U])

	wave.add_rules(Tile.LINE_V, [Vector3i.UP, Vector3i.DOWN], [Tile.LINE_V,Tile.T_L,Tile.T_R,Tile.X])
	wave.add_rules(Tile.LINE_V, [Vector3i.RIGHT], [Tile.EMPTY,Tile.T_R,Tile.LINE_V])
	wave.add_rules(Tile.LINE_V, [Vector3i.LEFT], [Tile.EMPTY,Tile.T_L,Tile.LINE_V])

	wave.add_rules(Tile.T_L, [Vector3i.UP, Vector3i.DOWN], [Tile.T_L,Tile.T_R,Tile.LINE_V])
	wave.add_rules(Tile.T_L, [Vector3i.RIGHT], [Tile.EMPTY])
	wave.add_rules(Tile.T_L, [Vector3i.LEFT], [Tile.LINE_H,Tile.T,Tile.T_U,Vector2i(0,3),Tile.T_R])

	wave.add_rules(Tile.T_R, [Vector3i.UP, Vector3i.DOWN], [Tile.T_L,Tile.T_R,Tile.LINE_V])
	wave.add_rules(Tile.T_R, [Vector3i.LEFT], [Tile.EMPTY])
	wave.add_rules(Tile.T_R, [Vector3i.RIGHT], [Tile.LINE_H,Tile.T,Tile.T_U,Vector2i(0,3),Tile.T_L])

	wave.add_rules(Tile.EMPTY, [Vector3i.UP, Vector3i.DOWN], [Tile.LINE_H])
	wave.add_rules(Tile.EMPTY, [Vector3i.RIGHT, Vector3i.LEFT], [Tile.LINE_V])
	wave.add_rules(Tile.EMPTY, [Vector3i.RIGHT, Vector3i.LEFT,Vector3i.UP, Vector3i.DOWN], [Tile.EMPTY])

	wave.add_rules(Tile.CORNER_TR, [Vector3i.RIGHT], [Tile.CORNER_TL,Tile.T_L,Tile.LINE_H,Tile.T,Tile.T_U,Tile.X,Tile.CORNER_BL])
	wave.add_rules(Tile.CORNER_TR, [Vector3i.DOWN], [Tile.LINE_V,Tile.T_L,Tile.T,Tile.T_R,Tile.CORNER_BR,Tile.CORNER_BL,Tile.X])
	wave.add_rules(Tile.CORNER_TR, [Vector3i.UP, Vector3i.LEFT], [Tile.EMPTY])
	wave.add_rules(Tile.CORNER_TR, [Vector3i.UP], [Tile.CORNER_TR,Tile.T_R,Tile.T_R,Tile.LINE_V])
	wave.add_rules(Tile.CORNER_TR, [Vector3i.LEFT], [Tile.LINE_V,Tile.T_L,Tile.CORNER_TL])

	wave.add_rules(Tile.CORNER_TL, [Vector3i.LEFT], [Tile.CORNER_TR,Tile.T_R,Tile.LINE_H,Tile.T,Tile.T_U,Tile.X,Tile.CORNER_BR])
	wave.add_rules(Tile.CORNER_TL, [Vector3i.DOWN], [Tile.LINE_V,Tile.T_L,Tile.T,Tile.T_R,Tile.CORNER_BR,Tile.CORNER_BL,Tile.X])
	wave.add_rules(Tile.CORNER_TL, [Vector3i.UP, Vector3i.RIGHT], [Tile.EMPTY])
	wave.add_rules(Tile.CORNER_TL, [Vector3i.UP], [Tile.CORNER_TR,Tile.T_R,Tile.T_R,Tile.LINE_V])
	wave.add_rules(Tile.CORNER_TL, [Vector3i.RIGHT], [Tile.CORNER_TR,Tile.T_R,Tile.LINE_V])

	wave.add_rules(Tile.CORNER_BR, [Vector3i.RIGHT], [Tile.CORNER_TL,Tile.T_L,Tile.LINE_H,Tile.T,Tile.T_U,Tile.X,Tile.CORNER_BL])
	wave.add_rules(Tile.CORNER_BR, [Vector3i.UP], [Tile.LINE_V,Tile.T_L,Tile.T_U,Tile.T_R,Tile.CORNER_TR,Tile.CORNER_TL,Tile.X])
	wave.add_rules(Tile.CORNER_BR, [Vector3i.DOWN, Vector3i.LEFT], [Tile.EMPTY])
	wave.add_rules(Tile.CORNER_BR, [Vector3i.DOWN], [Tile.LINE_H,Tile.CORNER_TR,Tile.CORNER_TL,Tile.CORNER_TR])
	wave.add_rules(Tile.CORNER_BR, [Vector3i.LEFT], [Tile.LINE_V,Tile.T_L,Tile.CORNER_TL])

	wave.add_rules(Tile.CORNER_BL, [Vector3i.LEFT], [Tile.CORNER_TR,Tile.T_R,Tile.LINE_H,Tile.T,Tile.T_U,Tile.X,Tile.CORNER_BR])
	wave.add_rules(Tile.CORNER_BL, [Vector3i.UP], [Tile.LINE_V,Tile.T_L,Tile.T_U,Tile.T_R,Tile.CORNER_TR,Tile.CORNER_TL,Tile.X])
	wave.add_rules(Tile.CORNER_BL, [Vector3i.DOWN, Vector3i.RIGHT], [Tile.EMPTY])
	wave.add_rules(Tile.CORNER_BL, [Vector3i.DOWN], [Tile.LINE_H,Tile.CORNER_TR,Tile.CORNER_TL,Tile.CORNER_BL])
	wave.add_rules(Tile.CORNER_BL, [Vector3i.RIGHT], [Tile.CORNER_TR,Tile.T_R,Tile.LINE_V])
	
	wave.generate()
