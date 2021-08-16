    // MPU-6050 Short Example Sketch
    // By Arduino User JohnChi
    // August 17, 2014
    // Public Domain
    #include<Wire.h>
    const int MPU_addr=0x68;  // I2C address of the MPU-6050
    int16_t AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ;
    const int stepPin1 = 3; 
    const int dirPin1 = 4; 
    const int stepPin2 = 5; 
    const int dirPin2 = 6; 
    void setup(){
      Wire.begin();
      Wire.beginTransmission(MPU_addr);
      Wire.write(0x6B);  // PWR_MGMT_1 register
      Wire.write(0);     // set to zero (wakes up the MPU-6050)
      Wire.endTransmission(true);
            // Sets the two pins as Outputs
      pinMode(stepPin1,OUTPUT); 
      pinMode(dirPin1,OUTPUT);
      pinMode(stepPin2,OUTPUT); 
      pinMode(dirPin2,OUTPUT);
      Serial.begin(9600);
    }
    void loop(){
      Wire.beginTransmission(MPU_addr);
      Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H)
      Wire.endTransmission(false);
      Wire.requestFrom(MPU_addr,14,true);  // request a total of 14 registers
      AcX=Wire.read()<<8|Wire.read();  // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)    
      AcY=Wire.read()<<8|Wire.read();  // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
      AcZ=Wire.read()<<8|Wire.read();  // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)
      Tmp=Wire.read()<<8|Wire.read();  // 0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L)
      GyX=Wire.read()<<8|Wire.read();  // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
      GyY=Wire.read()<<8|Wire.read();  // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
      GyZ=Wire.read()<<8|Wire.read();  // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)
      Serial.print("AcX = "); Serial.print(AcX);
      Serial.print(" | AcY = "); Serial.print(AcY);
      Serial.print(" | AcZ = "); Serial.print(AcZ);
      Serial.print(" | Tmp = "); Serial.print(Tmp/340.00+36.53);  //equation for temperature in degrees C from datasheet
      Serial.print(" | GyX = "); Serial.print(GyX);
      Serial.print(" | GyY = "); Serial.print(GyY);
      Serial.print(" | GyZ = "); Serial.println(GyZ);
      if (AcZ < -2000)
      {
      digitalWrite(dirPin1,HIGH); // Enables the motor to move in a particular direction
      digitalWrite(dirPin2,LOW); // Enables the motor to move in a particular direction
      // Makes 200 pulses for making one full cycle rotation
      for(int x = 0; x < 25; x++) {
        digitalWrite(stepPin1,HIGH); 
        digitalWrite(stepPin2,HIGH); 
        delayMicroseconds(500); 
        digitalWrite(stepPin1,LOW); 
        digitalWrite(stepPin2,LOW); 
        delayMicroseconds(500); 
      }
      }
            if (AcZ > 2000)
      {
      digitalWrite(dirPin1,LOW); // Enables the motor to move in a particular direction
      digitalWrite(dirPin2,HIGH); // Enables the motor to move in a particular direction
      // Makes 200 pulses for making one full cycle rotation
      for(int x = 0; x < 25; x++) {
        digitalWrite(stepPin1,HIGH); 
        digitalWrite(stepPin2,HIGH); 
        delayMicroseconds(500); 
        digitalWrite(stepPin1,LOW); 
        digitalWrite(stepPin2,LOW); 
        delayMicroseconds(500); 
      }
      }
      
         }
