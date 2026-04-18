extends Node3D

signal job_selected(job_name)

func _ready() -> void:
	for child in get_children():
		var job = child as Job
		if job == null: continue
		job.job_pressed.connect(_on_job_pressed)

func _on_job_pressed(job_name):
	job_selected.emit(job_name)
	
