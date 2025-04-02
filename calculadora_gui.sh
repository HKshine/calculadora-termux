#!/bin/bash

while true; do
    OPCAO=$(whiptail --title "Calculadora" --menu "Escolha uma operação:" 15 40 5 \
    "1" "Adição" \
    "2" "Subtração" \
    "3" "Multiplicação" \
    "4" "Divisão" \
    "5" "Sair" 3>&1 1>&2 2>&3)

    if [[ $? -ne 0 || $OPCAO -eq 5 ]]; then
        whiptail --title "Saindo" --msgbox "Obrigado por usar a calculadora!" 10 40
        exit 0
    fi

    NUM1=$(whiptail --title "Número 1" --inputbox "Digite o primeiro número:" 10 40 3>&1 1>&2 2>&3)
    NUM2=$(whiptail --title "Número 2" --inputbox "Digite o segundo número:" 10 40 3>&1 1>&2 2>&3)

    if [[ -z "$NUM1" || -z "$NUM2" ]]; then
        whiptail --title "Erro" --msgbox "Valores inválidos!" 10 40
        continue
    fi

    case $OPCAO in
        1) RESULTADO=$(echo "$NUM1 + $NUM2" | bc) ;;
        2) RESULTADO=$(echo "$NUM1 - $NUM2" | bc) ;;
        3) RESULTADO=$(echo "$NUM1 * $NUM2" | bc) ;;
        4) 
            if [[ $NUM2 -eq 0 ]]; then
                whiptail --title "Erro" --msgbox "Divisão por zero não é permitida!" 10 40
                continue
            fi
            RESULTADO=$(echo "scale=2; $NUM1 / $NUM2" | bc) ;;
    esac

    whiptail --title "Resultado" --msgbox "O resultado é: $RESULTADO" 10 40
done
