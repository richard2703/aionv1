import Swal from "sweetalert2";

const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

export const confirmDialog = (title, text, icon) => {

    return Swal.fire({
        title: title,
        text: text,
        icon: icon,
        position: 'center',
        width: 300,
        showConfirmButton: icon=="error" ? false : true,
        showCancelButton: true ,
        confirmButtonColor: '#262626',
        cancelButtonColor: '#D3B553',
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Aceptar!'
    });
};

export const showToast = (title, icon) => {
    Toast.fire({
        icon: icon,
        title: title
    });
};
