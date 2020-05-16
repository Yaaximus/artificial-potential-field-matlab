# MATLAB implementation of Artificial Potential Field

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/37571161/58729174-20680600-8402-11e9-82de-1bd83a97d370.png">
</p>

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/37571161/58729193-2fe74f00-8402-11e9-8be1-1d5c4ffa7872.png">
</p>

## Running instruction:
- Run the main.m file from directory. 
- User can defined objects like Robot, Goal, Obstacles in this file.

## Requirements
- MATLAB

## Features
- Single robot and goal object
- Two obstacle objects

## Objective:
- The aim is to move mobile robot from start point to goal point while avoiding obstacle in path

## Flow Chart Artificial Potential Field:

![FlowChart](https://user-images.githubusercontent.com/37571161/58727204-1c85b500-83fd-11e9-87a1-1e3b23c4ecef.PNG)

## Attractive – Repulsive Potentials

![5](https://user-images.githubusercontent.com/37571161/82117049-224be600-9787-11ea-9ff5-f87e8f16afb9.png)

### Figure 2

Obstacle for Environment

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/37571161/82117052-2546d680-9787-11ea-92a6-f6e88733a1d5.png">
</p>

### Figure 3

Obstacles and Target in Environment

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/37571161/82117065-31cb2f00-9787-11ea-97a7-d68f5730aea4.png">
</p>

## Mobile Robot Phases:

### The Glide Phase

Initially, Mobile Robot(MR) will move in a straight line from start-point to End-point, unless and until the sensor detects an obstacle

### The Maneuver Phase

The Mobile Robot(MR) enters the maneuver phase to “go around” the obstacle, as shown in Figure 4 below with the
robot (R), obstacle (O) and target(T) in a line. Artificial Particles (AP) are placed, at equal angle
intervals, on a circle of radius C t .

#### Figure 4

2D Grid

<p align="center">
  <img width="460" height="300" src="https://user-images.githubusercontent.com/37571161/82116764-71911700-9785-11ea-8186-dd7be093694a.png">
</p>

## Selection Criteria for point

![selection](https://user-images.githubusercontent.com/37571161/82116813-be74ed80-9785-11ea-9fae-8fb9b8f20b7c.png)

## Cost Function

![cost](https://user-images.githubusercontent.com/37571161/82116852-f2501300-9785-11ea-8613-3d0eb0b7b413.png)

## Algorithm Development (Steps and Input Data)

![Algorithm_Development_(Steps_and_Input_Data)1](https://user-images.githubusercontent.com/37571161/82116873-1f042a80-9786-11ea-8eb6-b13ee28d8b97.png)

![Algorithm_Development_(Steps_and_Input_Data)2](https://user-images.githubusercontent.com/37571161/82116897-5d014e80-9786-11ea-9c16-bb362c04c9df.png)

![Algorithm_Development_(Steps_and_Input_Data)3](https://user-images.githubusercontent.com/37571161/82116916-8cb05680-9786-11ea-9f43-f1680d7f10be.png)

## Limitations

![4](https://user-images.githubusercontent.com/37571161/82116950-bd908b80-9786-11ea-8d39-d0f89e5fc4ff.png)