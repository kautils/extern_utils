
###
* requirement
* object has free function which relese itself like below to avoid memory leak. 
    ```c++
    struct object{ 
        ... 
        void object::free(); 
        ...
    };
    void object::free(){ delete this }
    ``` 