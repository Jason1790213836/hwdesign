#include <iostream>
using namespace std;

#define SIZE 5

class RingBuffer {
public:
    int buf[SIZE];
    int head = 0;

    void push(int val) {
        buf[head] = val;
        head = (head + 1) % SIZE;
    }

    void print() {
        for(int i=0;i<SIZE;i++)
            cout << buf[i] << " ";
        cout << endl;
    }
};

int main() {
    RingBuffer rb;
    rb.push(1);
    rb.push(2);
    rb.push(3);
    rb.print();
}