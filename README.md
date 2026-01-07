# UZ Practicas AS Profesores

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


## Realización de las Prácticas en QEMU-KVM

### Creación de un Disco Duro

```
qemu-img create -f qcow2 <nombre>.qcow2 <tamaño>
```

### Lanzar una Máquina Virtual para Instalar Debian

```
qemu-system-x86_64 \
    -m 1G -cpu max -enable-kvm \
    -no-reboot \
    -device virtio-net-pci,netdev=net0 -netdev user,id=net0 \
    -drive if=virtio,cache=unsafe,file=<nombre_del_disco>.qcow2 \
    -device ide-cd,drive=cdrom,bootindex=0 \
    -drive if=none,id=cdrom,format=raw,file=<iso_de_debian>
```

### Ejecutar una Máquina Virtual

```
qemu-system-x86_64 \
    -m 1G -cpu max -enable-kvm \
    -no-reboot \
    -device virtio-net-pci,netdev=net0 -netdev user,id=net0 \
    -drive if=virtio,cache=unsafe,file=<nombre_del_disco>.qcow2
```

### Ejecutar una Máquina Virtual con una subred

```
qemu-system-x86_64 \
  -m 1G -cpu max -enable-kvm \
  -no-reboot \
  -drive file=<nombre_del_disco>.qcow2,format=qcow2 \
  -netdev user,id=net0,net=<red>,dhcpstart=<inicio_del_dhpc> \
  -device virtio-net-pci,netdev=net0
```

### Creación de un Disco Incremental

```
qemu-img create -f qcow2 -b <disco_base> -F qcow2 <disco_incremental>
```

## FAQs

### ¿Un test se ha qudado bloqueado?

```
pkill -f /usr/libexec/bats-core/bats
```

### Time out recurrente en los tests

Incrementa el valor de la variable `BATS_TEST_TIMEOUT=` en el fichero `tests/common.sh`.
