//: Playground - noun: a place where people can play

import Cocoa

struct Vector{
    var x : Double
    var y : Double
    
    init() {
//        x = 0;
//        y = 0;
        self.init(x: 0, y: 0);
    }
    
    init(x: Double, y: Double) {
        self.x = x;
        self.y = y
    }
    
    func vectorByAddingVector(vector : Vector) -> Vector {
        return Vector(x: x + vector.x,
                      y: y + vector.y)
    }
    
    static func +(left : Vector, right : Vector) -> Vector {
        return left.vectorByAddingVector(vector: right)
    }
    
    static func *(left : Vector, right : Double) -> Vector {
        return Vector(x: left.x * right, y: left.y * right)
    }
    
    var lenght: Double {
        return sqrt(x*x + y*y)
    }
    
    var description : String {
        return ("\(x), \(y)")
    }
}

let gravity = Vector(x: 0.0, y:-9.8);
//gravity.x
//gravity.y
//let doubleGravity = gravity.vectorByAddingVector(vector: gravity)
let doubleGravity = gravity + gravity;
let mulGrav = gravity * 2.0
print("Hi")
print("Gravity is \(gravity)");


class Particle {
    var position : Vector
    var velocity : Vector
    var acceleration : Vector

    init(position : Vector) {
        self.position = position
        velocity = Vector();
        acceleration = Vector();
    }
    
    convenience init () {
        self.init(position: Vector());
    }
    
    func tick(dt : TimeInterval) {
        velocity = velocity + acceleration * dt;
        position = position + velocity * dt
        position.y = max(0, position.y);
    }
}

class Simulation {
    var particles : [Particle] = [Particle]()
    var time : TimeInterval = 0.0
    
    func addParticle(particle : Particle) {
        particles.append(particle);
    }
    
    func tick(dt : TimeInterval) {
        for particle in particles {
            particle.acceleration = particle.acceleration + gravity;
            particle.tick(dt: dt)
            particle.acceleration = Vector();
            particle.position.y;
        }
        time += dt
        
        particles = particles.filter({ (particle) -> Bool in
            let live = particle.position.y > 0.0
            if !live {
                print("Particle terminated at time \(self.time)")
            }
            return live
        })
    }
}

class Rocket : Particle {
    let thrust : Double
    var thrustTimeRemaining : TimeInterval
    let direction = Vector(x: 0, y: 1)
    
    convenience init (thrust : Double, thurstTime : TimeInterval) {
        self.init(position: Vector(), thrust: thrust, thurstTime: thurstTime)
    }
    
    init(position : Vector, thrust :Double, thurstTime : TimeInterval) {
        self.thrust = thrust //10
        self.thrustTimeRemaining = thurstTime //60
        super.init(position: position)
    }
    
    override func tick(dt: TimeInterval) {
        if thrustTimeRemaining > 0.0 {
            let thrustTime  = min (dt, thrustTimeRemaining)
            let thrustToApply = thrust * thrustTime
            let thrustForce = direction * thrustToApply
            acceleration = acceleration + thrustForce
            thrustTimeRemaining -= thrustTime
        }
        super.tick(dt: dt)
    }
}

let simulation = Simulation()

let rocket = Rocket(thrust: 10.0, thurstTime: 60.0);
simulation.addParticle(particle: rocket)

//let ball = Particle()
//ball.acceleration = Vector(x: 0, y: 100);
//simulation.addParticle(particle: ball)

while simulation.particles.count > 0 && simulation.time < 40 {
    simulation.tick(dt: 1.0)
}














