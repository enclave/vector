module vector

import math

struct Vector3<T> {
mut:
	x T
	y T
	z T
}

// Ported from Quake III Arena
// https://github.com/id-Software/Quake-III-Arena/blob/master/code/game/q_math.c#L552-#L572
// Returns the inverse square root of a number
[unsafe]
fn inverse_rsqrt(number f32) f32 {
	threehalfs := f32(1.5)
	x2 := number * f32(0.5)
	mut y := number
	mut i := unsafe { (*(&int(&y))) }
	i = 0x5f3759df - (i >> 1)
	y = unsafe { (*(&f32(&i))) }
	y *= (threehalfs - x2 * y * y)
	return y
}

// Adds two vectors and returns a Vector3
pub fn (v Vector3<T>) add<T>(v2 Vector3<T>) Vector3<T> {
	return Vector3{v.x + v2.x, v.y + v2.y, v.z + v2.z}
}

// Returns a vector with each of its axis checked if it goes below the min or beyond the max value
// and clamped accordingly
pub fn (v Vector3<T>) clamp<T>(min Vector3<T>, max Vector3<T>) Vector3<T> {
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
pub fn (v Vector3<T>) compare<T>(v2 Vector3<T>) bool {
	return v.x == v2.x && v.y == v2.y && v.z == v2.z
}

// Product of two vectors which returns a vector quantity
pub fn (v Vector3<T>) cross_product<T>(v2 Vector3<T>) Vector3<T> {
	return Vector3{v.y * v2.z - v.z * v2.y, v.z * v2.x - v.x * v2.z, v.x * v2.y - v.y * v2.x}
}

// Inverses a vector
pub fn (v Vector3<T>) inverse<T>() Vector3<T> {
	return Vector3{-v.x, -v.y, -v.z}
}

// Returns the vector length
pub fn (v Vector3<T>) length<T>() f64 {
	// length_sqr := v.length_squared<T>()
	length_sqr := v.x * v.x + v.y * v.y + v.z * v.z
	return math.sqrt(length_sqr)
}

// Returns the vector length squared
pub fn (v Vector3<T>) length_squared<T>() T {
	return v.x * v.x + v.y * v.y + v.z * v.z
}

// Returns a unit vector
pub fn (v Vector3<T>) normalize<T>() Vector3<T> {
	length := math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
	length_inv := 1 / length
	return Vector3{v.x * length_inv, v.y * length_inv, v.z * length_inv}
}

// Returns a unit vector
pub fn (v Vector3<T>) normalize_fast<T>() Vector3<T> {
	length_inv := unsafe { inverse_rsqrt(v.x * v.x + v.y * v.y + v.z * v.z) }
	return Vector3{v.x * length_inv, v.y * length_inv, v.z * length_inv}
}

// Returns a vector with each of its axis multiplied by a scale factor
pub fn (v Vector3<T>) scale<T>(scale_factor T) Vector3<T> {
	return Vector3{v.x * scale_factor, v.y * scale_factor, v.z * scale_factor}
}

// Subtracts two vectors and returns a vector
pub fn (v Vector3<T>) subtract<T>(v2 Vector3<T>) Vector3<T> {
	return Vector3{v.x - v2.x, v.y - v2.y, v.z - v2.z}
}