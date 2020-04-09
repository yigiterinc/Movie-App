
export default {
    loginSuccessful() {
        const welcomeMessage = 'You are successfully logged in'
        this.$swal('Please wait ', welcomeMessage, 'success');
    },

    loginFailed() {
        const errorMessage = 'Please check your credentials and try again'
        this.$swal('Error', errorMessage, 'error');
    }
}