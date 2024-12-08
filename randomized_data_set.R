# Set the seed for reproducibility
# set.seed(123)

# Capture command-line arguments
args <- commandArgs(trailingOnly = TRUE)
commit_hash <- args[1]

# Print the commit hash for confirmation
cat("Using commit hash:", commit_hash, "\n")


# Load the necessary library
library(dplyr)
library(readxl)

original_data_set<- readxl::read_excel(path = "./HumanResourcesDataAA5221_Reduced_Fall2.xlsx",sheet = 1)

# Randomize specified columns in the dataset
modified_data_set <- original_data_set %>%
  mutate(
    satisfaction_level = satisfaction_level + 0.03,
    last_evaluation = last_evaluation - 0.02,
    left = sample(c(0, 1), size = n(), replace = TRUE, prob = c(0.3, 0.7)),
    Work_accident = sample(c(0, 1), size = n(), replace = TRUE, prob = c(0.7, 0.4))
  )

# Save the modified dataset
write.csv(modified_data_set, paste0("./data/modified_data_set_",commit_hash,".csv"), row.names = FALSE)
