# UZ Practicas AS

Repositorio con los tests de la asignatura de Administración de Sistemas de Unizar.

## Estructura

```
├── REAME.md
src
│   ├── Pr2
│   │   ├── practica2_1.sh
│   │   ├── practica2_2.sh
│   │   ├── practica2_3.sh
│   │   ├── practica2_4.sh
│   │   ├── practica2_5.sh
│   │   └── practica2_6.sh
│   ├── Pr3
│   │   └── practica3.sh
│   └── Pr4
│       └── practica4.sh
└── tests
    ├── common.sh
    ├── Pr2
    │   ├── test_practica2_1.bats
    │   ├── test_practica2_2.bats
    │   ├── test_practica2_3.bats
    │   ├── test_practica2_4.bats
    │   ├── test_practica2_5.bats
    │   └── test_practica2_6.bats
    ├── Pr3
    │   └── test_practica3.bats
    └── Pr4
        └── test_practica4.bats
```

* *src*: ejercicios de las prácticas.
* *tests*: test para validar las prácticas.

## Requisitos

Paquete `bats` y `bash`. En Debian: `sudo apt install bats`, Fedora: `sudo dnf install bats`, Arch: `sudo pacman -S bats`.

## Ejecutar un test

```
./tests/Pr{2,3,4}/<test>
```

## FAQs

### ¿Un test se ha qudado bloqueado?

```
pkill -f /usr/libexec/bats-core/bats
```

### Time out recurrente en los tests

Incrementa el valor de la variable `BATS_TEST_TIMEOUT=` en el fichero `tests/common.sh`.
