<template>
    <div class="container shadow d-flex flex-column justify-content-center p-lg-2 p-sm-2 p-md-2">
        <div v-if="poem" class="poem">
            <h1>{{ poem.title }}</h1>
            <span>{{ poem.inception + poem.source?'in ' + poem.source: ' aus unbekannter Quelle' }} </span>
            <div class="poem-text m-lg-5 p-3"><span>{{ poem.text + poem.text }}</span>
            </div>
        </div>
    </div>
</template>

<script>
    import dataService from '../../dataService'
    import {EventBus} from "@/main";

    export default {
        name: "poem",
        data() {
            return {poem: {title: 'test', text: 'foobar', inception: 1337}}
        },
        created() {
            this.getPoem()
        },
        methods: {
            getPoem() {
                const title = this.$route.params.title;
                dataService.getPoem(title).then(result => {
                    this.poem = result[0];
                    EventBus.$emit('loaded');
                })
            }
        },
        watch: {
            $route() {
                this.getPoem()
            }
        }
    }
</script>

<style lang="stylus" scoped>
    .container
        .poem
            min-width 100%

            .poem-text
                height 75vh
                overflow-y auto
                overflow-x hidden
    @media (max-width: 768px)
        .container
            height 100vh


</style>