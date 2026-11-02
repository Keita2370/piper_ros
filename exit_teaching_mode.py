from piper_sdk import *
import time
p = C_PiperInterface_V2('can0'); p.ConnectPort(); time.sleep(0.2)
p.MotionCtrl_1(0x02, 0, 0)   # 恢复 (reset)
time.sleep(0.5)
print(p.GetArmStatus().arm_status.ctrl_mode)

