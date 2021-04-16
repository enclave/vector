module vector

import math

struct Vector3<T> {
mut:
	x T
	y T
	z T
}

// Adds two vectors and returns a Vector3
fn (v Vector3<T>) add<T>(v2 Vector3<T>) Vector3<T> {
	return Vector3{v.x + v2.x, v.y + v2.y, v.z + v2.z}
}

// Checks each axis of the vector and clamps if an axis goes below the min or beyond the max value
fn (v Vector3<T>) clamp<T>(min Vector3<T>, max Vector3<T>) Vector3<T> {
	mut vec := Vector3{}

	if v.x < min.x {
		vec.x = min.x
	} else if v.x > max.x {
		vec.x = max.x
	}

	if v.y < min.y {
		vec.y = min.y
	} else if v.y > max.y {
		vec.y = max.y
	}

	if v.z < min.z {
		vec.z = min.z
	} else if v.z > max.z {
		vec.z = max.z
	}
	return vec
}

// Compares two vectors, axis by axis to determine if they are the same
fn (v Vector3<T>) compare<T>(v2 Vector3<T>) bool {
	return v.x == v2.x && v.y == v2.y && v.z == v2.z
}

// Product of two vectors which returns a vector quantity
fn (v Vector3<T>) cross_product<T>(v2 Vector3<T>) Vector3<T> {
	return Vector3 {
		v.y * v2.z - v.z * v2.y,
		v.z * v2.x - v.x * v2.z,
		v.x * v2.y - v.y * v2.x
	}
}

// Inverses a vector
fn (v Vector3<T>) inverse<T>() Vector3<T> {
	return Vector3{-v.x, -v.y, -v.z}
}

// Returns the vector length
fn (v Vector3<T>) length<T>() T {
	// length_sqr := v.length_squared<T>()
	length_sqr := v.x * v.x + v.y * v.y + v.z * v.z
	return T(math.sqrt(length_sqr))
}

// Returns the vector length squared
fn (v Vector3<T>) length_squared<T>() T {
	return v.x * v.x + v.y * v.y + v.z * v.z
}

// Returns a unit vector
fn (v Vector3<T>) normalize<T>() Vector3<T> {
	length_inv := 1 / math.sqrt(length_squared(v))
	return Vector3{v.x * length_inv, v.y * length_inv, v.z * length_inv}
}

// Multiplies each axis of a vector by a scale factor
fn (v Vector3<T>) scale<T>(scale_factor T) Vector3<T> {
	return Vector3{v.x * scale_factor, v.y * scale_factor, v.z * scale_factor}
}

// Subtracts two vectors and returns a vector
fn (v Vector3<T>) subtract<T>(v2 Vector3<T>) Vector3<T> {
	return Vector3{v.x - v2.x, v.y - v2.y, v.z - v2.z}
}