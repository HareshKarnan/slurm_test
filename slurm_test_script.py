import torch
import argparse
import os

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='argparse test')
    parser.add_argument('--env-name', default='InvertedPendulum-v2')
    parser.add_argument('--log-dir', default='/u/pstone/agents6/haresh/')
    args = parser.parse_args()

    path_to_save = os.path.join(args.log_dir, 'slurm_test')
    # if path doesnt exist, create one
    if not os.path.exists(path_to_save):
        os.makedirs(path_to_save)

    string_2_dump = 'Name of the environment is : ' + str(args.env_name) + '\n' \
        'This is just a test script. If this exists, Slurm submit works as expected. \n' \
        'CUDA Availability : ' + str(torch.cuda.is_available()) + '\n' \
        'Device Count : ' + str(torch.cuda.device_count()) + '\n'

    print(string_2_dump, file=open(os.path.join(path_to_save, 'my_slurm_log.txt'), 'w'))






