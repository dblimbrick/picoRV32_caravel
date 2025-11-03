// SPDX-FileCopyrightText: 2023 Efabless Corporation

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//      http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// SPDX-License-Identifier: Apache-2.0

#include <firmware_apis.h>

void main(){
    ManagmentGpio_outputEnable();
    ManagmentGpio_write(0);
    enableHkSpi(0);
    GPIOs_configureAll(GPIO_MODE_USER_STD_OUT_MONITORED);
    GPIOs_loadConfigs();
    User_enableIF();
    LogicAnalyzer_outputEnable(2,1);
    LogicAnalyzer_write(2,2);
    LogicAnalyzer_write(2,0);
    ManagmentGpio_write(1);

    // Simple test - just signal completion
    // The actual DFFRAM testing is done by the cocotb testbench
    // via direct Wishbone access from the Caravel management core
    
    ManagmentGpio_write(0);
    return;
}