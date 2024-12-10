# Set the seed for reproducibility
# set.seed(123)

# Capture command-line arguments
args <- commandArgs(trailingOnly = TRUE)
commit_hash <- args[1]
left_prob_0 <- as.numeric(args[2])
left_prob_1 <- as.numeric(args[3])
work_accident_prob_0 <- as.numeric(args[4])
work_accident_prob_1 <- as.numeric(args[5])
sat_level<- as.numeric(args[6])
eval_level<- as.numeric(args[7])

# Print the commit hash for confirmation
cat("Using commit hash:", commit_hash, "\n")


# Load the necessary library
library(dplyr)
library(readxl)

original_data_set<- readxl::read_excel(path = "./data_set.xlsx",sheet = 1)

# Randomize specified columns in the dataset
modified_data_set <- original_data_set %>%
  mutate(
    satisfaction_level = satisfaction_level + sat_level,
    last_evaluation = last_evaluation - eval_level,
    left = sample(c(0, 1), size = n(), replace = TRUE, prob = c(left_prob_0, left_prob_1)),
    Work_accident = sample(c(0, 1), size = n(), replace = TRUE, prob = c(work_accident_prob_0, work_accident_prob_1))
  )

# Save the modified dataset
write.csv(modified_data_set, paste0("./data/modified_data_set_",commit_hash,".csv"), row.names = FALSE)
