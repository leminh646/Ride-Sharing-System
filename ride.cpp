#include <iostream>
#include <vector>
#include <memory>

using namespace std;

class Ride {
    protected:
    string rideID;
    string pickupLocations;
    string dropoffLocations;
    double distance;

    public:
    Ride (string id, string pickup, string dropoff, double dist)
    : rideID(id), pickupLocations(pickup), dropoffLocations(dropoff), distance(dist) {}

    virtual double fare() const = 0;

    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID
             << ", From: " << pickupLocations
             << ", To: " << dropoffLocations
             << ", Distance: " << distance << " km"
             << ", Fare: $" << fare() << endl;
    }

    virtual ~Ride() {}
};

class StandardRide : public Ride {
    public:
    StandardRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 1.5;
    }
};

class PremiumRide : public Ride {
    public:
    PremiumRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 2.5;
    }
};

class Driver {
    private:
    string driverID;
    string name;
    double rating;
    vector<shared_ptr<Ride>> assignedRides;

    public:
    Driver(string id, string name, double rating)
        : driverID(id), name(name), rating(rating) {}

    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "Driver ID: " << driverID << ", Name: " << name
             << ", Rating: " << rating << endl;
        cout << "Completed Rides: " << endl;
        for (const auto& ride : assignedRides) {
            ride->rideDetails();
        }
    }
};

class Rider {
    private:
    string riderID;
    string name;
    vector<shared_ptr<Ride>> requestedRides;

    public:
    Rider(string id, string name)
        : riderID(id), name(name) {}

    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "Rider ID: " << riderID << ", Name: " << name << endl;
        cout << "Ride History: " << endl;
        for (const auto& ride: requestedRides) {
            ride->rideDetails();
        }
    }
};

int main() {
    shared_ptr<Ride> ride1 = make_shared<StandardRide>("R001", "A", "B", 10.0);
    shared_ptr<Ride> ride2 = make_shared<PremiumRide>("R002", "c", "D", 8.5);

    vector<shared_ptr<Ride>> rides = { ride1, ride2 };
    cout << "Ride Summary:\n";
    for (const auto& r: rides) {
        r->rideDetails();
    }

    Driver driver("D001", "Amber", 4.8);
    driver.addRide(ride1);
    driver.addRide(ride2);
    cout << "\nDriver Info:\n";
    driver.getDriverInfo();

    Rider rider("U001", "Brad");
    rider.requestRide(ride1);
    rider.requestRide(ride2);
    cout << "\nRider Info:\n";
    rider.viewRides();

    return 0;
}
