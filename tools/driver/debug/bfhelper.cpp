#include "../../../include/config/config.hpp"
#if GNALC_EXTENSION_BRAINFK
#include <iostream>

#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/utils/utils.hpp"

int main(int argc, char *argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <brainfk code>" << std::endl;
        return 1;
    }
    std::cout << BrainFk::to_mybf_presentation(argv[1]) << std::endl;
    return 0;
}
#endif