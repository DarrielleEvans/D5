pipeline {
  agent any
   stages {
    stage ('Clean') {
      steps {
        sh '''#!/bin/bash
        echo "command to run the pkill.sh"
        '''
     }
   }
 stage ('Deploy') {
  steps {
     sh '''#!/bin/bash
      echo "command to run the setup2.sh"
      scp setup2.sh ubuntu@3.91.91.253:/home/ubuntu/
      ssh ubuntu@3.91.91.253 'chmod 700 /home/ubuntu/setup2.sh && bash /home/ubuntu/setup2.sh'
    '''
      }
    }
  }
}
