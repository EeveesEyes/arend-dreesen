<template>
    <div class="content p-3 d-flex flex-column justify-content-center">
        <h1 class="nav-item mb-3" @click="navItemSelect('/home')">Arend Dreesen</h1>
        <div class="content-nav">
            <multilevel-accordion :tree="tree" :marginLeft="2">
                <template slot-scope="{ tree }">
                    <div class="nav-item" :class="tree.children ? 'nav-branch':'nav-leaf'" @click="select(tree)">
                        <span>{{ tree.title }}</span>
                    </div>
                </template>
            </multilevel-accordion>
        </div>

        <span @click="navItemSelect('/imprint')" class="ml-auto mr-auto mt-auto nav-footer">Impressum</span>

    </div>
</template>

<script>
    import poems from '../json/gedichte.json'
    import MultilevelAccordion from "vue-multilevel-accordion";
    import {EventBus} from "@/main";

    export default {
        data() {
            return {
                tree: {
                    children: [
                        {
                            title: "Gedichte",
                            children: poems
                        }
                    ]
                },
                poems: poems,
                current: null,
                activeNav: true
            }
        },
        name: "NavBar",
        components: {
            MultilevelAccordion
        },
        methods: {
            select(item) {
                if (!item.children) this.$router.push('/poem/' + item.title).catch(() => {
                });
            },
            extendNav() {
                this.activeNav = !this.activeNav;
            },
            navItemSelect(path) {
                this.$router.push(path).catch(() => {
                });
                EventBus.$emit('nav-item-selected');

            }
        },

    }
</script>

<style scoped lang="stylus">
    json('../assets/colors.json')

    .content

        h1
            color accent
        background darker

        .content-nav
            width 100%
            overflow: auto

        .nav-item
            cursor: pointer
        height 100vh

        .nav-footer
            align-self end
            color accent

        .nav-branch
            font-size 1.5rem

        .nav-leaf
            font-size 1rem

    //@media handheld


</style>