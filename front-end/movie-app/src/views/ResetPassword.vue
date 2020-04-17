<template>
    <div class="container">
        <v-form
                ref="form"
                v-model="valid"
                lazy-validation
        >
            <v-text-field
                    v-model="password"
                    label="Password"
                    type="password"
                    required
            ></v-text-field>
            <v-text-field
                    v-model="passwordRepeated"
                    type="password"
                    label="Confirm"
                    required
            ></v-text-field>


            <v-btn color="primary"
                    @click="resetPass()"
                    :disabled="!valid">
                Reset Password
            </v-btn>

        </v-form>
    </div>
</template>

<script>
    import ServicesMixin from '../mixins/services-mixin'

    export default {
        name: "ForgotPassword",
        mixins: [ServicesMixin],
        data() {
            return {
                password: '',
                passwordRepeated: '',
            }
        },
        methods: {
            validate () {
                this.$refs.form.validate()
            },
            resetPass() {
                this.resetPassword(this.$route.params.token, this.password).then(() => {
                    this.$swal('Success', 'Your password is changed', 'success')
                    this.$router.push('/login')
                }).catch(error => {
                    console.error(error)
                })
            }
        },
        computed: {
            valid: function () {
                return this.password === this.passwordRepeated && this.password.length >= 5
            }
        }
    }
</script>

<style scoped>

</style>