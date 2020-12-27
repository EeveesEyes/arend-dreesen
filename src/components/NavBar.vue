<template>
    <div class="content p-0 d-flex flex-column justify-content-center">
        <h1 class="mb-3 mt-5" @click="navItemSelect('/home')">Arend Dreesen</h1>
        <div class="content-nav">
            <multilevel-accordion class="nav-root p-1 pt-5 pb-3 user-select-none"
                                  :tree="tree" :marginLeft="4">
                <template slot-scope="{ tree, level, expanded, leaf }">
                    <div class="nav-item m-1 p-1 rounded-pill shadow-sm cursor-pointer
                                hover:shadow-lg"
                         :class="`${level === 0 ? 'nav-branch' : ''}
                                  ${expanded ? 'nav-extended' : ''}
                                  ${leaf ? 'pl-3':''}`"
                         style="transition: box-shadow 0.5s, background-color 0.5s, color 0.5s;"
                         @click="select(tree.title, leaf)">
                        <span v-if="!leaf" class="font-bold text-xl">
                            {{ expanded ? "&#8722;" : "&#43;" }}
                        </span>
                        <span class="text-center">{{ tree.title }}</span>
                    </div>
                </template>
            </multilevel-accordion>
        </div>
        <span @click="navItemSelect('/imprint')"
              class="ml-auto mr-auto mt-auto nav-footer">Impressum</span>
    </div>
</template>

<script>
    import MultilevelAccordion from "vue-multilevel-accordion";
    import {EventBus} from "@/main";
    import dataService from "@/dataService";
    import INDEXNAMES from "../../jsonData/indexMap.json"

    export default {
        data() {
            return {
                tree: {children: []},
                current: null,
                activeNav: true
            }
        },
        created() {
            Object.keys(INDEXNAMES).forEach(name => {
                dataService.getIndex(name).then(result => {
                    this.tree.children.push({title: INDEXNAMES[name].title, children: result})
                    // this.poem = result[0];
                    EventBus.$emit('index-loaded');
                })
            });
        },
        name: "NavBar",
        components: {
            MultilevelAccordion
        },
        methods: {
            select(text, leaf) {
                if (leaf) this.$router.push('/poem/' + text).catch(() => {
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
            cursor pointer
            font-family 'Redressed';
        background darker

        .content-nav
            width 100%
            overflow: auto

        .nav-item
            cursor: pointer
            z-index 90
            background-color nav-bg

        height 100vh

        .nav-footer
            align-self end
            color accent
            cursor pointer

        .nav-branch
            //font-size 1.5rem
            color nav-branch

        .nav-extended
            color nav-highlight

        .nav-leaf
            font-size 1rem
</style>