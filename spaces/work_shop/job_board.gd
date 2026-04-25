extends Node3D

signal job_selected(job_name)

@export var jobs: Dictionary[String, Node3D]

func hide_jobs():
	for job in jobs:
		jobs[job].visible = false

func unlock_job(key):
	if jobs.has(key):
		jobs[key].visible = true

func load_job_array(jobs_array := ["job_1"]) -> void:
	for job in jobs_array:
		if job is String:
			unlock_job(job)

func _ready() -> void:
	hide_jobs()
	#unlock_job("job_1")
	for child in get_children():
		var job = child as Job
		if job == null: continue
		job.job_pressed.connect(_on_job_pressed)

func _on_job_pressed(job_name):
	job_selected.emit(job_name)
