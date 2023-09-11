### kautil_extern_utils
* prepared for factors whose definition can not be hidden such as the implementation of foreach.
* assumed to use along with dlopen/Loadlibrary.

### example 

```c++
// this repository dose not include below module
#include "kautil/sharedlib/sharedlib.h"
#include "kautil/recursive_directory_iterator/recursive_directory_iterator.h"

int main(){

    auto dl = __dlopen(PATH_TO_SHARED_LIB,rtld_lazy|rtld_nodelete);
    if(!dl){ fprintf(stderr,"fail to open sharedlib\n");throw false; }
    
    auto recursive_itr_factory = (decltype(kautil::filesystem::recursive_directory_iterator)*) kautil_dlsym(dl,"recursive_directory_iterator");
    auto recursive_itr_free = (decltype(kautil::filesystem::recursive_directory_iterator_free)*) kautil_dlsym(dl,"recursive_directory_iterator_free");

    if(!recursive_itr_factory){ fprintf(stderr,"fail to find symbol\n");throw false; }
    if(!recursive_itr_free){ fprintf(stderr,"fail to find symbol\n");throw false; }

    auto sc=kautil::extern_helper::scope(recursive_itr_factory("."));
    for(auto & e : kautil::extern_helper::iterator(&sc)){ printf("%s\n",e.path());fflush(stdout);}
    
    __dlclose(dl);
    return 0;
}

int main(){
    tmain_kautil_wstd_fs_walk_shared();
}
```