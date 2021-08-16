    /*     Simple Stepper Motor Control Exaple Code
     *      
     *  by Dejan Nedelkovski, www.HowToMechatronics.com
     *  
     */
    // defines pins numbers
    const int stepPin1 = 3; 
    const int dirPin1 = 4; 
    const int stepPin2 = 5; 
    const int dirPin2 = 6; 
    void setup() {
      // Sets the two pins as Outputs
      pinMode(stepPin1,OUTPUT); 
      pinMode(dirPin1,OUTPUT);
      pinMode(stepPin2,OUTPUT); 
      pinMode(dirPin2,OUTPUT);
    }
    void loop() {
      digitalWrite(dirPin1,HIGH); // Enables the motor to move in a particular direction
      digitalWrite(dirPin2,LOW); // Enables the motor to move in a particular direction
      // Makes 200 pulses for making one full cycle rotation
      for(int x = 0; x < 200; x++) {
        digitalWrite(stepPin1,HIGH); 
        digitalWrite(stepPin2,HIGH); 
        delayMicroseconds(500); 
        digitalWrite(stepPin1,LOW); 
        digitalWrite(stepPin2,LOW); 
        delayMicroseconds(500); 
      }
      delay(1000); // One second delay
      
      digitalWrite(dirPin,LOW); //Changes the rotations direction
      // Makes 400 pulses for making two full cycle rotation
      for(int x = 0; x < 400; x++) {
        digitalWrite(stepPin,HIGH);
        delayMicroseconds(500);
        digitalWrite(stepPin,LOW);
        delayMicroseconds(500);
      }
      delay(1000);
    }
