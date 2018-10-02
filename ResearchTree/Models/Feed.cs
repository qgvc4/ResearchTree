﻿using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchTree.Models
{
    public class Feed
    {
        [Key]
        public string Id { get; set; }

        [Required]
        public string PeopleId { get; set; }

        [Required]
        public string Title { get; set; }

        [Required]
        public string Description { get; set; }

        [Required]
        public DateTime Date { get; set; }

        public byte[] Attachment { get; set; }
    }
}
