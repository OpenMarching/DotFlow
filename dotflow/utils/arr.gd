class_name UtilArrays
extends Node


func find_neighbors_float(arr: Array[float], target: float) -> Array[float]:
	for i in range(arr.size() - 1):
		if target >= arr[i] and target <= arr[i + 1]:
			return [arr[i], arr[i + 1]]
		else:
			return[0.0,0.0]
	return[0.0,0.0]
