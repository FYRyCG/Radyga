extends Spatial

export var boneName = "midfinger_r"

func _ready():	
	# Создание attachment для определения позиции оружия
	var Skeleton = get_node("Armature/Skeleton")
	var Attachment = BoneAttachment.new()
	Attachment.set_name("WeaponAttachment")
	var SpatialNode = Spatial.new()
	SpatialNode.set_name("WeaponPosition")
	Attachment.add_child(SpatialNode)
	Attachment.bone_name = boneName
	Skeleton.add_child(Attachment)

	# Поворот персонажа навстречу курсору
	get_node("Armature").global_transform.rotated(Vector3(0,1,0), 180)
