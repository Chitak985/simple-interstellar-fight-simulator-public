extends GPUParticles3D

var timer1 = 200

func _ready():
	emitting = true

func _process(_delta):
	if(!emitting):
		queue_free()
