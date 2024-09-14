onerror {resume}
quietly WaveActivateNextPane {} 0

radix -unsigned

add wave /rgb_tb/*
add wave /rgb_tb/map
add wave /rgb_tb/DUT/*

update
