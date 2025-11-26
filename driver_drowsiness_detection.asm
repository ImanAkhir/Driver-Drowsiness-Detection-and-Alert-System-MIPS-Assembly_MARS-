# ===========================================
# Drowsiness Detection System (MIPS - MARS)
# Author: Iman A., Zullaikha Z., Aisha A., Sofia M.
# ===========================================

.data
init_msg:          .asciiz "Initializing Camera, Heart Rate Sensor, and Steering Wheel Sensor...\n"
detect_msg:        .asciiz "Detecting eyes and face landmarks...\n"
success_msg:       .asciiz "Detection successful! Data captured.\n"

eye_open_msg:      .asciiz "Eyes State. Monitoring...(0 = closed, 1 = open)\n"
eye_closed_msg:    .asciiz "Eyes Closed...\n"
awake_msg:         .asciiz "Driver Awake. Continue monitoring...\n"

heart_rate_msg:    .asciiz "Checking Heart Rate...(1 = normal, 0 = abnormal)\n"
heart_normal_msg:  .asciiz "Heart Rate is normal. Continue monitoring...\n"
heart_abnormal_msg:.asciiz "Heart Rate is abnormal...\n"

steering_msg:      .asciiz "Checking Steering Movement...(1 = consistent, 0 = inconsistent)\n"
steering_consistent_msg: .asciiz "Steering Movement is consistent. Continue monitoring...\n"
steering_inconsistent_msg: .asciiz "Steering Movement is inconsistent...\n"

alert_msg:         .asciiz "Driver Drowsy! Triggering Alert...(1 = reacted, 0 = unresponsive)\n"
escalate_msg:      .asciiz "Driver Unresponsive. Escalating Alert (Emergency Messages Sent)...\n"

continue_msg:      .asciiz "Driver Awake. Do you want to continue monitoring...(1 = Yes, 0 = No)\n"
error_msg:         .asciiz "Invalid input! Please enter 1 for Yes or 0 for No.\n"
stop_msg:          .asciiz "Program Terminated. Thank you!\n"

.text
.globl main

# ===========================================
# MAIN PROGRAM
# ===========================================
main:
    # Initialization message
    li $v0, 4
    la $a0, init_msg
    syscall

detect:
    # Simulated detection
    li $v0, 4
    la $a0, detect_msg
    syscall

    # Simulated: both face & eyes detected
    li $t0, 1
    li $t1, 1

    beq $t0, 1, eyes_detected
    j detection_failed

eyes_detected:
    beq $t1, 1, detection_success
    j detection_failed

detection_success:
    li $v0, 4
    la $a0, success_msg
    syscall
    j monitoring_loop

detection_failed:
    li $v0, 4
    la $a0, error_msg
    syscall
    j detect


# ===========================================
# MONITORING LOOP
# ===========================================
monitoring_loop:

    # Check eye state
    jal check_eye_state
    beq $v0, 0, handle_eye_closed
    beq $v0, 1, eyes_open_action
    j monitoring_loop


# ===========================================
# EYES CLOSED PATH
# ===========================================
handle_eye_closed:
    li $v0, 4
    la $a0, eye_closed_msg
    syscall
    j monitor_heart_rate


monitor_heart_rate:
    jal check_heart_rate
    beq $v0, 1, heart_rate_normal

    # Abnormal HR
    li $v0, 4
    la $a0, heart_abnormal_msg
    syscall

    # Must check steering next
    jal check_steering
    j monitoring_loop

heart_rate_normal:
    li $v0, 4
    la $a0, heart_normal_msg
    syscall
    j monitoring_loop


# ===========================================
# STEERING CHECK
# ===========================================
check_steering:
    jal check_steering_movement
    beq $v0, 1, steering_normal

    # Inconsistent
    li $v0, 4
    la $a0, steering_inconsistent_msg
    syscall

    jal trigger_alert
    j monitoring_loop

steering_normal:
    li $v0, 4
    la $a0, steering_consistent_msg
    syscall
    j monitoring_loop


# ===========================================
# EYES OPEN PATH
# ===========================================
eyes_open_action:
    li $v0, 4
    la $a0, awake_msg
    syscall
    j monitoring_loop


# ===========================================
# ALERT SYSTEM
# ===========================================
trigger_alert:
    li $v0, 4
    la $a0, alert_msg
    syscall

    jal monitor_response
    beq $v0, 1, stop_alert

    jal escalate_alert
    j monitoring_loop

stop_alert:
    li $v0, 4
    la $a0, awake_msg
    syscall

continue_prompt:
    li $v0, 4
    la $a0, continue_msg
    syscall

    li $v0, 5
    syscall

    blt $v0, 0, invalid_continue
    bgt $v0, 1, invalid_continue
    beq $v0, 1, monitoring_loop

    j end_program

invalid_continue:
    li $v0, 4
    la $a0, error_msg
    syscall
    j continue_prompt


escalate_alert:
    li $v0, 4
    la $a0, escalate_msg
    syscall
    jr $ra


# ===========================================
# FUNCTIONS
# ===========================================
check_eye_state:
    li $v0, 4
    la $a0, eye_open_msg
    syscall

    li $v0, 5
    syscall   # user enters 0/1

    blt $v0, 0, invalid_eye
    bgt $v0, 1, invalid_eye
    jr $ra

invalid_eye:
    li $v0, 4
    la $a0, error_msg
    syscall
    j check_eye_state


check_heart_rate:
    li $v0, 4
    la $a0, heart_rate_msg
    syscall

    li $v0, 5
    syscall

    blt $v0, 0, invalid_hr
    bgt $v0, 1, invalid_hr
    jr $ra

invalid_hr:
    li $v0, 4
    la $a0, error_msg
    syscall
    j check_heart_rate


check_steering_movement:
    li $v0, 4
    la $a0, steering_msg
    syscall

    li $v0, 5
    syscall

    blt $v0, 0, invalid_st
    bgt $v0, 1, invalid_st
    jr $ra

invalid_st:
    li $v0, 4
    la $a0, error_msg
    syscall
    j check_steering_movement


monitor_response:
    li $v0, 5
    syscall

    blt $v0, 0, invalid_resp
    bgt $v0, 1, invalid_resp
    jr $ra

invalid_resp:
    li $v0, 4
    la $a0, error_msg
    syscall
    j monitor_response


# ===========================================
# END PROGRAM
# ===========================================
end_program:
    li $v0, 4
    la $a0, stop_msg
    syscall

    li $v0, 10
    syscall
