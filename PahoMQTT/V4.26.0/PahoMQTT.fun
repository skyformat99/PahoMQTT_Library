
FUNCTION_BLOCK PahoMQTT_Cyclic
	VAR_INPUT
		LoggerLevel : USINT; (*0: ERROR, 1: WARNING, 2: INFO, 3: SUCCESS, 4: TRACE*)
		Resume : BOOL; (*Start the main thread (if not already running)*)
		Suspend : BOOL; (*Pause the main thread from a system perspective, yield everything*)
	END_VAR
	VAR_OUTPUT
		Running : BOOL; (*Main thread is running*)
		Status : UINT; (*Status from Rtk functions*)
	END_VAR
	VAR
		_LoggerLevel : USINT;
		_Resume : BOOL;
		_Suspend : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION PahoMQTT_Exit : BOOL (*Kill the main thread, should be used in _EXIT*)
END_FUNCTION

FUNCTION PahoMQTT_Sleep : BOOL (*Sleep the main thread for a certain period of time (ms)*)
	VAR_INPUT
		Milliseconds : UDINT;
	END_VAR
END_FUNCTION

FUNCTION PahoMQTT_IsAlive : BOOL (*Check whether the SDK_Exit has been called to kill the thread. should be used inside the main while() loop, to disconnect properly if the task is retransferred*)
END_FUNCTION

FUNCTION_BLOCK PahoMQTT_Init
	VAR_INPUT
		EnableLogger : BOOL; (*Activate AR Logging: MQTT_LOG and enable ERROR messages*)
		MainThread : UDINT; (*Function pointer to main thread with following signature: void sample(UDINT param)*)
		ThreadParam : UDINT; (*Pointer to parameter (structure) passed to the main thread in param*)
		SuspendThread : BOOL; (*Create the main thread in suspended mode,  that you can start it with PahoMQTT_Cyclic.Resume. Useful for debugging*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL;
		Error : BOOL; (*Error occured during initialization*)
		ErrorInfo : STRING[80]; (*Error message*)
		Status : UINT; (*Status from RtkCreateTask*)
	END_VAR
END_FUNCTION_BLOCK
