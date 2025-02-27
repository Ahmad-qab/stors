% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/srnorm.R
\name{srnorm_optimize}
\alias{srnorm_optimize}
\title{Optimizing Normal Distribution proposal}
\usage{
srnorm_optimize(
  mean = NULL,
  sd = NULL,
  xl = -Inf,
  xr = Inf,
  steps = NULL,
  proposal_range = NULL,
  theta = 0.1,
  target_sample_size = 1000,
  verbose = FALSE,
  symmetric = FALSE
)
}
\arguments{
\item{mean}{(optional) Numeric. Mean parameter of the Normal distribution. Defaults to \code{NULL}, which implies a scalable proposal with \code{mean = 0}.}

\item{sd}{(optional) Numeric. Standard deviation of the target Normal distribution. Defaults to \code{NULL}, which implies a scalable proposal with \code{sd = 1}.}

\item{xl}{Numeric. Left truncation bound for the target distribution. Defaults to \code{-Inf}, representing no left truncation.}

\item{xr}{Numeric. Right truncation bound for the target distribution. Defaults to \code{Inf}, representing no right truncation.}

\item{steps}{(optional) Integer. Desired number of steps in the proposal. Defaults to \code{NULL}, which means the number of steps is determined automatically during optimization.}

\item{proposal_range}{(optional) Numeric vector. Specifies the range for optimizing the steps part of the proposal. Defaults to \code{NULL}, indicating automatic range selection.}

\item{theta}{Numeric. A parameter for proposal optimization. Defaults to 0.1.}

\item{target_sample_size}{(optional) Integer. Target sample size for proposal optimization. Defaults to \code{1000}.}

\item{verbose}{Boolean. If \code{TRUE}, detailed optimization information, including areas and steps, will be displayed. Defaults to \code{FALSE}.}

\item{symmetric}{Boolean. If \code{TRUE}, the proposal will target only the right tail of the distribution, reducing the size of the cached proposal and making sampling more memory-efficient.
An additional uniform random number will be sampled to determine the sample's position relative to the mode of the distribution.
While this improves memory efficiency, the extra sampling may slightly impact performance, especially when the proposal efficiency is close to 1. Defaults to \code{FALSE}.}
}
\value{
The user does not need to store the returned value, because the package internally cashes the proposal. However, we explain here the full returned proposal for advanced users.

A list containing the optimized proposal and related parameters for the specified built-in distribution:
\describe{
\item{\code{data}}{A data frame with detailed information about the proposal steps, including:
\describe{
\item{\code{x}}{The start point of each step on the x-axis.}
\item{\code{s_upper}}{The height of each step on the y-axis.}
\item{\code{p_a}}{Pre-acceptance probability for each step.}
\item{\code{s_upper_lower}}{A vector used to scale the uniform random number when the sample is accepted.}
}}
\item{\code{areas}}{A numeric vector containing the areas under:
\describe{
\item{\code{left_tail}}{The left tail bound.}
\item{\code{steps}}{The middle steps.}
\item{\code{right_tail}}{The right tail bound.}
}}
\item{\code{steps_number}}{An integer specifying the number of steps in the proposal.}
\item{\code{sampling_probabilities}}{A numeric vector with:
\describe{
\item{\code{left_tail}}{The probability of sampling from the left tail.}
\item{\code{left_and_middle}}{The combined probability of sampling from the left tail and middle steps.}
}}
\item{\code{unif_scaler}}{A numeric scalar, the inverse probability of sampling from the steps part of the proposal (\eqn{\frac{1}{p(lower < x < upper)}}). Used for scaling uniform random values.}
\item{\code{lt_properties}}{A numeric vector of 5 values required for Adaptive Rejection Sampling (ARS) in the left tail.}
\item{\code{rt_properties}}{A numeric vector of 6 values required for ARS in the right tail.}
\item{\code{alpha}}{A numeric scalar representing the uniform step area.}
\item{\code{tails_method}}{A string, either \code{"ARS"} (Adaptive Rejection Sampling) or \code{"IT"} (Inverse Transform), indicating the sampling method for the tails.}
\item{\code{proposal_bounds}}{A numeric vector specifying the left and right bounds of the target density.}
\item{\code{cnum}}{An integer representing the cache number of the created proposal in memory.}
\item{\code{symmetric}}{A numeric scalar indicating the symmetry point of the proposal, or \code{NULL} if not symmetric.}
\item{\code{f_params}}{A list of parameters for the target density that the proposal is designed for.}
\describe{
\item{\code{mean}}{The mean of the target distribution.}
\item{\code{sd}}{The standard deviation of the target distribution.}
}
\item{\code{is_symmetric}}{A logical value indicating whether the proposal is symmetric.}
\item{\code{proposal_type}}{A string indicating the type of the generated proposal:
\describe{
\item{\code{"scaled"}}{The proposal is "scalable" and standardized with \code{mean = 0} and \code{sd = 1}. This is used when parameters \code{mean} and \code{sd} are either \code{NULL} or not provided. Scalable proposals are compatible with \code{\link{srnorm}}.}
\item{\code{"custom"}}{The proposal is "custom" when either \code{mean} or \code{sd} is provided. Custom proposals are compatible with \code{\link{srnorm_custom}}.}
}}
\item{\code{target_function_area}}{A numeric scalar estimating the area of the target distribution.}
\item{\code{dens_func}}{A string containing the hardcoded density function.}
\item{\code{density_name}}{A string specifying the name of the target density distribution.}
\item{\code{lock}}{An identifier used for saving and loading the proposal from disk.}
}
}
\description{
The \code{srnorm_optimize()} function generates an optimized proposal for a targeted Normal distribution.
The proposal can be customized and adjusted based on various options provided by the user.
}
\details{
When \code{srnorm_optimize()} is explicitly called:
\itemize{
\item A proposal is created and cached. If no parameters are provided, a standard proposal is created (\code{mean = 0}, \code{sd = 1}).
\item Providing \code{mean} or \code{sd} creates a custom proposal, which is cached for use with \code{srnorm_custom()}.
\item The optimization process can be controlled via parameters such as \code{steps}, \code{proposal_range}, or
\code{theta}. If no parameters are provided, the proposal is optimized via brute force based on the.
\code{target_sample_size}.
}
}
\examples{
# Generate scalable proposal that with mean = 0 and sd = 1, that has 4096 steps
scalable_proposal <- srnorm_optimize(steps = 4096)


# Generate custom proposal that with mean = 2 and sd = 1
scalable_proposal <- srnorm_optimize(mean = 2, sd = 1)


}
\seealso{
\code{\link{srnorm}}: Function to sample from a scalable proposal generated by \code{srnorm_optimize()}.
\code{\link{srnorm_custom}}: Function to sample from a custom proposal tailored to user specifications.
}
