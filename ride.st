"------------------
 Ride Class
------------------"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    Ride class >> newWithID: id pickup: pickup dropoff: dropoff distance: dist [
        ^ self new initializeWithID: id pickup: pickup dropoff: dropoff distance: dist
    ]

    Ride >> initializeWithID: id pickup: pickup dropoff: dropoff distance: dist [
        rideID := id.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist.
        ^ self
    ]

    Ride >> fare [
        self subclassResponsibility
    ]

    "Return one line of formatted ride information"
    Ride >> summaryString [
        ^ 'Ride ID: ', rideID,
          ', From: ', pickupLocation,
          ', To: ', dropoffLocation,
          ', Distance: ', distance printString, ' km, Fare: $', self fare printString
    ]
]

"------------------
 StandardRide Class
------------------"
Ride subclass: StandardRide [
    StandardRide >> fare [
        ^ distance * 1.5
    ]
]

"------------------
 PremiumRide Class
------------------"
Ride subclass: PremiumRide [
    PremiumRide >> fare [
        ^ distance * 2.5
    ]
]

"------------------
 Driver Class
------------------"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> newWithID: id name: n rating: r [
        ^ self new initializeWithID: id name: n rating: r
    ]

    Driver >> initializeWithID: id name: n rating: r [
        driverID := id.
        name := n.
        rating := r.
        assignedRides := OrderedCollection new.
        ^ self
    ]

    Driver >> addRide: aRide [
        assignedRides add: aRide.
    ]

    "Return multi-line string about the driver and rides"
    Driver >> infoString [
        | lf info |
        lf := Character codePoint: 10.  "Linefeed"
        
        info := 'Driver ID: ', driverID,
                ', Name: ', name,
                ', Rating: ', rating printString,
                lf.
                
        info := info, 'Completed Rides:', lf.
        
        assignedRides do: [:ride |
            info := info, ride summaryString, lf.
        ].
        ^ info
    ]
]

"------------------
 Rider Class
------------------"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> newWithID: id name: n [
        ^ self new initializeWithID: id name: n
    ]

    Rider >> initializeWithID: id name: n [
        riderID := id.
        name := n.
        requestedRides := OrderedCollection new.
        ^ self
    ]

    Rider >> requestRide: aRide [
        requestedRides add: aRide.
    ]

    "Return multi-line string about the rider and rides"
    Rider >> infoString [
        | lf info |
        lf := Character codePoint: 10.  "Linefeed"
        
        info := 'Rider ID: ', riderID,
                ', Name: ', name,
                lf.
                
        info := info, 'Ride History:', lf.
        
        requestedRides do: [:ride |
            info := info, ride summaryString, lf.
        ].
        ^ info
    ]
]

"------------------
 Test & Print Output
------------------"
| lf ride1 ride2 driver rider |

"Define a LF once for convenience"
lf := Character codePoint: 10.

"Create some rides"
ride1 := StandardRide newWithID: 'R001' pickup: 'A' dropoff: 'B' distance: 10.
ride2 := PremiumRide newWithID: 'R002' pickup: 'C' dropoff: 'D' distance: 8.5.

"Create a driver"
driver := Driver newWithID: 'D001' name: 'Amber' rating: 4.8.
driver addRide: ride1.
driver addRide: ride2.

"Create a rider"
rider := Rider newWithID: 'U001' name: 'Brad'.
rider requestRide: ride1.
rider requestRide: ride2.

"------------------
 Print multi-line output to Transcript
------------------"
Transcript show: 'Ride Summary:', lf.
Transcript cr.
Transcript show: ride1 summaryString, lf.
Transcript cr.
Transcript show: ride2 summaryString, lf, lf.
Transcript cr.

Transcript show: 'Driver Info:', lf.
Transcript cr.
Transcript show: driver infoString, lf.
Transcript cr.

Transcript show: 'Rider Info:', lf.
Transcript cr.
Transcript show: rider infoString, lf.
